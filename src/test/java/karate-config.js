function fn() {    
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
	baseUrl:'https://api-play.bbva.com.ar/apibbvachannel/accounts',
	//loginUrlDesa:'https://api-play.bbva.com.ar/oauth/authorize?client_id=bbva-oauth-client&code_challenge=MChCW5vD-3h03HMGFZYskOSTir7II_MMTb8a9rJNhnI&code_challenge_method=S256&redirect_uri=https%3A%2F%2Fapi-play.bbva.com.ar%2Fbbvacli%2Fcallback%2Fplay&response_type=code&scope=openid+offline+accounts.savings.ars.read+accounts.current.ars.read+accounts.write&state=dquxgokntfljgwbhhjfumezs'
	loginUrlTest:'https://api-work.bbva.com.ar/oauth/authorize?client_id=bbva-oauth-client&code_challenge=MChCW5vD-3h03HMGFZYskOSTir7II_MMTb8a9rJNhnI&code_challenge_method=S256&redirect_uri=https%3A%2F%2Fapi-play.bbva.com.ar%2Fbbvacli%2Fcallback%2Fwork&response_type=code&scope=openid+offline+accounts.savings.ars.read+accounts.current.ars.read+accounts.write&state=dquxgokntfljgwbhhjfumezs'

  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}