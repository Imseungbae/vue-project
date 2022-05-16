<template>
  <section>
    <transition-group name="list" tag="ul">
      <li v-for="list in todoList" :key="list" class="shadow"> 
        <i class="checkBtn fa fa-check"></i>
          내용: {{list.content}}
        <i class="checkBtn fa fa-check"></i>
          글쓴이: {{list.author}}
        <span class="removeBtn" type="button" @click="removeTodoList(list.seq_no)">
          <i class="fa fa-trash-o" aria-hidden="true"></i>
        </span>
      </li>
    </transition-group>
  </section>
</template>
<script>
// axios 라이브러리 import
import axios from 'axios'

export default {
  props:['propsdata'],
  data() {
    return {
      todoList: []
    }
  },
  methods: {
    removeTodo(item, idx) {
        this.$emit('removeTodo', item, idx);
    },
    removeTodoList(seq_no) {
        axios.delete('http://13.209.83.211:22001/todo/' + seq_no)
        .then(res=>{
          const {data} = res;
          console.log(data);
        });
    }
  },
  created(){
    axios.get('http://13.209.83.211:22001/todo/list')
    .then(res=>{
      this.todoList = res.data;
      console.log(res.data);
    })
  }
}
</script>

<style scoped>
  @import "//maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css";
  ul {
    list-style-type: none;
    padding-left: 0px;
    margin-top: 0;
    text-align: left;
  }
  li {
    display: flex;
    min-height: 50px;
    height: 50px;
    line-height: 50px;
    margin: 0.5rem 0;
    padding: 0 0.9rem;
    background: white;
    border-radius: 5px;
  }
  .checkBtn {
    line-height: 45px;
    color: #62acde;
    margin-right: 5px;
  }
  .removeBtn {
    margin-left: auto;
    color: #de4343;
  }


  .list-item {
    display: inline-block;
    margin-right: 10px;
  }
  .list-move {
    transition: transform 1s;
  }
  .list-enter-active, .list-leave-active {
    transition: all 1s;
  }
  .list-enter, .list-leave-to {
    opacity: 0;
    transform: translateY(30px);
  }
</style>