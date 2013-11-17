require('shelljs/global');

var installBundle = function(gitPath) {
  gitPath = gitPath.trim().replace(/#.*/, '');
  if(!gitPath) { return; }
  var repoName = gitPath.replace(/.*\//, '');
  if(exec('git clone https://github.com/'+gitPath+'.git bundle/'+repoName).code != 0) {
    echo('Checkout failed for bundle '+gitPath);
    exit(1);
  }
};

cat('vimrc.bundles').split(/\r?\n/g).forEach(installBundle);