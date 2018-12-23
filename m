From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 23 Dec 2018 03:32:17 +0000
Subject: Re: [for-next][PATCH 2/5] tracing: Use str_has_prefix() helper for histogram code
Message-Id: <20181223033217.GD11421@danjae.aot.lge.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
 <20181222162856.666843139@goodmis.org>
In-Reply-To: <20181222162856.666843139@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Tom Zanussi <zanussi@linux.intel.com>, kernel-team@lge.com

On Sat, Dec 22, 2018 at 11:20:09AM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The tracing histogram code contains a lot of instances of the construct:
> 
>  strncmp(str, "const", sizeof("const") - 1)
> 
> This can be prone to bugs due to typos or bad cut and paste. Use the
> str_has_prefix() helper macro instead that removes the need for having two
> copies of the constant string.
> 
> Cc: Tom Zanussi <zanussi@linux.intel.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index c5448c103770..9d590138f870 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1881,8 +1881,8 @@ static int parse_action(char *str, struct hist_trigger_attrs *attrs)
>  	if (attrs->n_actions >= HIST_ACTIONS_MAX)
>  		return ret;
>  
> -	if ((strncmp(str, "onmatch(", sizeof("onmatch(") - 1) = 0) ||
> -	    (strncmp(str, "onmax(", sizeof("onmax(") - 1) = 0)) {
> +	if ((str_has_prefix(str, "onmatch(")) ||
> +	    (str_has_prefix(str, "onmax("))) {
>  		attrs->action_str[attrs->n_actions] = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->action_str[attrs->n_actions]) {
>  			ret = -ENOMEM;
> @@ -1899,34 +1899,34 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
>  {
>  	int ret = 0;
>  
> -	if ((strncmp(str, "key=", sizeof("key=") - 1) = 0) ||
> -	    (strncmp(str, "keys=", sizeof("keys=") - 1) = 0)) {
> +	if ((str_has_prefix(str, "key=")) ||
> +	    (str_has_prefix(str, "keys="))) {
>  		attrs->keys_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->keys_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if ((strncmp(str, "val=", sizeof("val=") - 1) = 0) ||
> -		 (strncmp(str, "vals=", sizeof("vals=") - 1) = 0) ||
> -		 (strncmp(str, "values=", sizeof("values=") - 1) = 0)) {
> +	} else if ((str_has_prefix(str, "val=")) ||
> +		   (str_has_prefix(str, "vals=")) ||
> +		   (str_has_prefix(str, "values="))) {
>  		attrs->vals_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->vals_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "sort=", sizeof("sort=") - 1) = 0) {
> +	} else if (str_has_prefix(str, "sort=")) {
>  		attrs->sort_key_str = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->sort_key_str) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "name=", sizeof("name=") - 1) = 0) {
> +	} else if (str_has_prefix(str, "name=")) {
>  		attrs->name = kstrdup(str, GFP_KERNEL);
>  		if (!attrs->name) {
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "clock=", sizeof("clock=") - 1) = 0) {
> +	} else if (str_has_prefix(str, "clock=")) {
>  		strsep(&str, "=");
>  		if (!str) {
>  			ret = -EINVAL;
> @@ -1939,7 +1939,7 @@ static int parse_assignment(char *str, struct hist_trigger_attrs *attrs)
>  			ret = -ENOMEM;
>  			goto out;
>  		}
> -	} else if (strncmp(str, "size=", sizeof("size=") - 1) = 0) {
> +	} else if (str_has_prefix(str, "size=")) {
>  		int map_bits = parse_map_size(str);
>  
>  		if (map_bits < 0) {
> @@ -3558,7 +3558,7 @@ static struct action_data *onmax_parse(char *str)
>  	if (!onmax_fn_name || !str)
>  		goto free;
>  
> -	if (strncmp(onmax_fn_name, "save", sizeof("save") - 1) = 0) {
> +	if (str_has_prefix(onmax_fn_name, "save")) {
>  		char *params = strsep(&str, ")");
>  
>  		if (!params) {
> @@ -4346,7 +4346,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
>  		str = hist_data->attrs->action_str[i];
>  
> -		if (strncmp(str, "onmatch(", sizeof("onmatch(") - 1) = 0) {
> +		if (str_has_prefix(str, "onmatch(")) {
>  			char *action_str = str + sizeof("onmatch(") - 1;

You'd better using the return value of str_has_prefix().


>  
>  			data = onmatch_parse(tr, action_str);
> @@ -4355,7 +4355,7 @@ static int parse_actions(struct hist_trigger_data *hist_data)
>  				break;
>  			}
>  			data->fn = action_trace;
> -		} else if (strncmp(str, "onmax(", sizeof("onmax(") - 1) = 0) {
> +		} else if (str_has_prefix(str, "onmax(")) {
>  			char *action_str = str + sizeof("onmax(") - 1;

Ditto.

Thanks,
Namhyung


>  
>  			data = onmax_parse(action_str);
> -- 
> 2.19.2
> 
> 
