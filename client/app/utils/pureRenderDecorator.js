import shouldComponentUpdate from 'react-pure-render/function';

function pureRenderDecorator(component) {
  component.prototype.shouldComponentUpdate = shouldComponentUpdate;
}

export default pureRenderDecorator;
