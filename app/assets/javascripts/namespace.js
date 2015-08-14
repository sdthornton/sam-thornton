module.exports = function namespace(target, classFunc) {
  const classObj = classFunc();
  const className = classObj.name;
  const names = target.split('.');
  let currentNamespace = window;

  names.forEach((name) => {
    currentNamespace[name] = currentNamespace[name] || {};
    currentNamespace = currentNamespace[name]
  });

  return currentNamespace[className] = classObj;
}
