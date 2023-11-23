/**
 * 
 */
  function toggleNotifications() {
        var notificationsTable = document.getElementById("notificationsTable");
        if (notificationsTable.style.display === "none" || notificationsTable.style.display === "") {
            notificationsTable.style.display = "block";
        } else {
            notificationsTable.style.display = "none";
        }
    }
    function dropdown() {
        var drop = document.getElementById("drop");
        if (drop.style.display === "none" || drop.style.display === "") {
        	drop.style.display = "block";
        } else {
        	drop.style.display = "none";
        }
    }