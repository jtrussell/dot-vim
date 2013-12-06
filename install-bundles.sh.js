require('shelljs/global');

var repoNameFromGitPath = function(gitPath) {
  return gitPath.replace(/.*\//, '');
};

var installBundle = function(gitPath) {
  var repoName = gitPath.replace(/.*\//, '');
  if(exec('git clone https://github.com/'+gitPath+'.git bundle/'+repoName).code !== 0) {
    echo('Checkout failed for bundle '+gitPath);
    exit(1);
  }
};

var updateBundle = function(gitPath) {
  var repoName = repoNameFromGitPath(gitPath);
  pushd('bundle/' + repoName);
  if(exec('git pull').code !== 0) {
    echo('Update failed for bundle ' + gitPath);
    exit(1);
  }
  popd();
};

var installOrUpdateBundle = function(gitPath) {
  gitPath = gitPath.trim().replace(/#.*/, '');
  if(!gitPath) { return; }
  var repoName = repoNameFromGitPath(gitPath);
  if(test('-d', 'bundle/' + repoName)) {
    updateBundle(gitPath);
  } else {
    installBundle(gitPath);
  }
};

cat('vimrc.bundles').split(/\r?\n/g).forEach(installOrUpdateBundle);
