
const date = Variable("", {
    poll: [1000, 'date "+%m/%d"']
})

const week = Variable("", {
    poll: [1000, 'date "+%A"']
})

const clock = Variable("", {
    poll: [1000, 'date "+%H:%M"']
})

export default () => Widget.Box({
    spacing: 8,
    vertical: false,
    children: [
        Widget.Label({
            label: week.bind()
        }),
        Widget.Label({
            label: date.bind()
        }),
        Widget.Label({
            label: clock.bind()
        })
    ]
})