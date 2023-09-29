function renderRPSLevelLine() {
    function random() {
        return Math.floor(Math.random() * 5);
    }
    let partialPattern1 = [];
    for (let i = 0; i < 5; i++) {
        const randomUnit = random()
        if (randomUnit === 1) {
            partialPattern1.push('r');
        } else if (randomUnit === 2) {
            partialPattern1.push('p');
        } else if (randomUnit === 3) {
            partialPattern1.push('s');
        } else {
            partialPattern1.push('_');
        }
    }
    let numberOfTruths = 0;
    partialPattern1.forEach(element => {
        if (element) {
            numberOfTruths++;
        }
    });
    if (numberOfTruths === 0) {
        return renderRPSLevelLine();
    }
    let partialPattern2 = partialPattern1.slice();
    partialPattern2.reverse();
    let totalPattern = partialPattern1.concat(partialPattern2);

    return totalPattern;
}

console.log(
    [
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
        renderRPSLevelLine(),
    ]
)