<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
      <div>
        <button v-for="entry in languages" :key="entry.title" @click="changeLocale(entry.language)">
        <flag :iso="entry.flag" v-bind:squared=false /> {{entry.title}}
        </button>
      </div>
    <HelloWorld :msg="message"/>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from '@/components/HelloWorld.vue'
import i18n from '@/plugins/i18n';

export default {
  name: 'Home',
  components: {
    HelloWorld
  },
  computed: {
    message: function() {
      return this.$t('hello');
    }
  },
  data() {
    return {
      languages: [
        {
          flag: 'us',
          language: 'en',
          title: 'English'
        },
        {
          flag: 'es',
          language: 'es',
          title: 'Español'
        }
      ]
    };
  },
  methods: {
    changeLocale(locale) {
      i18n.locale = locale;
      }
    }
}
</script>

<style scoped>
button {
  padding: 15px;
  border: 1px solid green;
  font-size: 18px;
  margin: 15px;
}
</style>