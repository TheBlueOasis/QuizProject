function addNew(questionId) {
  const formTemplate = document.querySelector('.form-block.hidden');
  const formBlock = formTemplate.cloneNode(true);
  formBlock.classList.remove('hidden');

  const targetDiv = document.querySelector('[data-question-id="' + questionId + '"] .target');
  const answers = document.querySelectorAll('[data-question-id="' + questionId + '"] .form-block:not(.hidden)');
  const newIndex = answers.length;

  const inputElements = formBlock.querySelectorAll('[name^="quiz[questions_attributes][0][possible_answers_attributes][new_answer]"]');

  inputElements.forEach(function(input) {
    input.name = input.name.replace('quiz[questions_attributes][0][possible_answers_attributes][new_answer]', 'quiz[questions_attributes][' + questionId + '][possible_answers_attributes][' + newIndex + ']');
  });

  targetDiv.append(formBlock);
}

function addEdit(questionId) {
  var formTemplate = document.querySelector('[data-question-id="' + questionId + '"] .form-block.hidden');
  if (!formTemplate) {
    const hiddenForms = document.querySelectorAll('.form-block.hidden');
    formTemplate = hiddenForms[0];
  }
  const formBlock = formTemplate.cloneNode(true);
  formBlock.classList.remove('hidden');

  const targetDiv = document.querySelector('[data-question-id="' + questionId + '"] .target');
  const answers = document.querySelectorAll('[data-question-id="' + questionId + '"] .form-block:not(.hidden)');
  const newIndex = answers.length;

  const inputs = formBlock.querySelectorAll('input[type="checkbox"][name*="[is_correct_answer]"], input[type="text"][name*="[answer]"], input[name*="[_destroy]"], input[type="hidden"]:not(.remove-checkbox)');
  inputs.forEach(function(input) {
    const questionsAttrIndex = input.name.indexOf('[questions_attributes]');
    if (questionsAttrIndex !== -1) {
      const nameSlice = input.name.slice(questionsAttrIndex);
      const updatedNameSlice = nameSlice.replace(/\[\d+\]/, '[' + questionId + ']');
      input.name = input.name.slice(0, questionsAttrIndex) + updatedNameSlice;
    }
    input.name = input.name.replace(/\[\d+\](?=\[[^\]]+\]$)/g, '[' + newIndex + ']');

    if (input.type === 'checkbox') {
      input.checked = false;
    } else if (input.name.includes('_destroy')) {
      input.value = 0;
    } else if (input.type === 'text') {
      input.value = '';
    }    
  });
  targetDiv.append(formBlock);
}

function remove(event) {
  const formDiv = event.target.closest('.form-block');
  const hiddenCheckbox = formDiv.querySelector('.remove-checkbox');

  hiddenCheckbox.value = true;
  formDiv.classList.add('hidden');
}

function removeQuestion(event) {
  const formDiv = event.target.closest('.question-form');
  const hiddenCheckbox = formDiv.querySelector('.remove-question-checkbox');

  hiddenCheckbox.value = true;
  formDiv.classList.add('hidden');
}
