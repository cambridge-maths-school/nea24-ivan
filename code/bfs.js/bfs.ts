let adjacencyList = {
        A: ['B', 'C'],
        B: ['A'],
        C:['A', 'B', 'E'],
        D: ['C'],
        E: ['C'],
        F:['B']
}

function traverse(adjacencyList:, startNode: string) {
    let queue = []
    let visited = []
    queue.push(startNode)
    visited.push(startNode)


}

function addition(a: number,b:number) {
    return a+b
}

export { addition }