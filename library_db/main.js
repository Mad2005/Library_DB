function fetchData(table) {
    fetch(`http://localhost:5000/${table}`)
        .then(response => response.json())
        .then(data => displayData(table, data))
        .catch(error => console.error('Error fetching data:', error));
}

function displayData(table, data) {
    let tableBody = document.getElementById(table + '-body');
    tableBody.innerHTML = ''; // Clear existing data

    data.forEach(row => {
        let tr = document.createElement('tr');
        Object.values(row).forEach(value => {
            let td = document.createElement('td');
            td.textContent = value;
            tr.appendChild(td);
        });
        tableBody.appendChild(tr);
    });
}

// Call function when section is displayed
function showSection(section) {
    document.querySelectorAll('.content').forEach(div => div.style.display = 'none');
    document.getElementById(section).style.display = 'block';
    fetchData(section); // Fetch data dynamically
}
