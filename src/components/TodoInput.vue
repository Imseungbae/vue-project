<template>
  <div class="inputBox shadow">
    <input type="text" v-model="newTodoItem" placeholder="Type what you have to do" v-on:keypress.enter="addTodo">
    <span class="addContainer" v-on:click="addTodo">
        <i class="addBtn fa fa-plus" aria-hidden="true"></i>
    </span>
  </div>
</template>

<script>
// axios 라이브러리 import
import axios from 'axios'

export default {
  
    data() {
        return {
            newTodoItem: ''
        }
    },
    methods: {
        addTodo() {
            if(this.newTodoItem != null) {
                var value = this.newTodoItem && this.newTodoItem.trim();
                axios({
                  method: 'post',
                  url: 'http://localhost:22001/todo/',
                  data: {
                    content: value,
                    author: 'default'
                  }
                }).then(res=>{
                  console.log(res);
                });
                this.clearInput();
            }   
        },
        clearInput() {
            this.newTodoItem = ''
        }
    }
}
</script>

<style scoped>
input:focus {
  outline: none;
}
.inputBox {
  background: white;
  height: 50px;
  line-height: 50px;
  border-radius: 5px;
}
.inputBox input {
  border-style: none;
  font-size: 0.9rem;
}
.addContainer {
  float: right;
  background: linear-gradient(to right, #6478FB, #8763FB);
  display: inline-block;
  width: 3rem;
  border-radius: 0 5px 5px 0;
}
.addBtn {
  color: white;
  vertical-align: middle;
}
</style>