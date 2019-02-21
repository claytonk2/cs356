import React from 'react';
import track from './track'
import parentView from "../view/parentView";

class parentTrack extends React.Component {
    constructor(props) {
        super(props);
        this.state={
            submit: false,
            startDate: new Date(),
            rowData: [
                {exercise: "exercise", sets: 0, reps: 0, weight: 0, effort: "medium"}
            ]

        }
    }
    onChangeDate(date){
        this.setState({
            startDate: date
        });
    }
    onSubmitTrack(){
        this.setState({
            submit: true
        });
    }

    render() {
        const ComponentToRender = this.state.submit ? parentView : track;
        return (<ComponentToRender onSubmitTrack={this.onSubmitTrack.bind(this)}
                                    onChangeDate={this.onChangeDate.bind(this)}
                                    startDate={this.state.startDate }
                                    rowData={this.state.rowData}/>
        );
    }
}
export default parentTrack