$(document).ready(function() {
  $('#users-table').dataTable({
    "processing": true,
    "serverSide": true,
    "ajax": $('#users-table').data('source'),
    "pagingType": "full_numbers",
    "iDisplayLength": 10,
    "aLengthMenu": [[5, 10, 20, 50, 100], [5, 10, 20, 50, 100]]
    // optional, if you want full pagination controls.
    // Check dataTables documentation to learn more about
    // available options.
  });
});
$.fn.dataTable.ext.errMode = 'throw';