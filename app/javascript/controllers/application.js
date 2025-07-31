import { Application } from '@hotwired/stimulus';
import RailsNestedForm from '@stimulus-components/rails-nested-form';
import CheckboxSelectAll from '@stimulus-components/checkbox-select-all';
import CustomAutocompleteController from "custom_autocomplete_controller"

const application = Application.start();
application.register('nested-form', RailsNestedForm);
application.register('checkbox-select-all', CheckboxSelectAll);
application.register('autocomplete', CustomAutocompleteController)

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
