const { spawnSync } = require('child_process');

function initialize(workshop) {
  workshop.load_workshop();

  if ('GITEA_ADMIN_SECRET' in process.env) {
    let namespace = process.env['SESSION_NAMESPACE']
    let admin_secret = process.env['GITEA_ADMIN_SECRET']
    kubectl = spawnSync('kubectl', ['-n', namespace, 'get', 'secret', admin_secret, '-o', 'jsonpath="{.data}"'], {timeout: 30000, encoding: "utf8"});
  
    if(kubectl.status == 0) {
      console.log('Got Gitea admin secret. Parsing.');
      const secret = kubectl.stdout.toString();
      const secret_data = JSON.parse(secret.substring(1,secret.length-1));
      const username = Buffer.from(secret_data.username, 'base64').toString("utf8");
      const password = Buffer.from(secret_data.password, 'base64').toString("utf8");
      workshop.data_variable('gitea_user', username);
      workshop.data_variable('gitea_password', password);
    } else {
      console.error("Error Gitea admin secret.");
      console.error(`stdout: ${kubectl.stdout}`)
      console.error(`stderr: ${kubectl.stderr}`);
    }
  } else {
    workshop.data_variable('gitea_user', process.env['GITEA_USER']);
    workshop.data_variable('gitea_password', process.env['GITEA_PASSWORD']);
  }
}

exports.default = initialize;

module.exports = exports.default;