import { Application } from '@hotwired/stimulus';
import RailsNestedForm from '@stimulus-components/rails-nested-form';
import CheckboxSelectAll from '@stimulus-components/checkbox-select-all';

const application = Application.start();
application.register('nested-form', RailsNestedForm);
application.register('checkbox-select-all', CheckboxSelectAll);

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
