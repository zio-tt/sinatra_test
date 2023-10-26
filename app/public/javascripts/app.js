document.addEventListener('DOMContentLoaded', () => {
  const inputForm     = document.getElementById('input-task-form');
  const addButton     = document.getElementById('add-task-button');
  const deleteButtons = document.querySelectorAll('[id^="delete-task-button"]');

  addButton.addEventListener('click', async () => {
    const taskContent = inputForm.value;
    try {
      const response = await fetch('/tasks/create', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({title: taskContent})
      });
      const data = await response.json();
      location.reload();
    } catch (error) {
      console.error('Error:', error);
    }
  });

  document.body.addEventListener('click', async (event) => {
    if (event.target.matches('[id^="delete-task-button"]')) {
      const button = event.target;
      const taskId = button.getAttribute('data-task-id');
      try {
        const response = await fetch(`/tasks/${taskId}`, {
          method: 'DELETE'
        });
        const data = await response.json();
        location.reload();
      } catch (error) {
        console.error('Error:', error);
      }
    }
  });
});
