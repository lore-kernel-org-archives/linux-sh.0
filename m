From: Tom Zanussi <zanussi@kernel.org>
Date: Sun, 23 Dec 2018 16:40:55 +0000
Subject: Re: [for-next][PATCH 4/5] tracing: Have the historgram use the result of str_has_prefix() for len of
Message-Id: <1545583255.4383.6.camel@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20181222162007.697862256@goodmis.org>
         <20181222162856.972056232@goodmis.org>
In-Reply-To: <20181222162856.972056232@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Joe Perches <joe@perches.com>, Namhyung Kim <namhyung@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

Hi Steve,

In the subject line, s/historgram/histogram...

On Sat, 2018-12-22 at 11:20 -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> As str_has_prefix() returns the length on match, we can use that for
> the
> updating of the string pointer instead of recalculating the prefix
> size.
> 
> Cc: Tom Zanussi  <zanussi@kernel.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace_events_hist.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c
> b/kernel/trace/trace_events_hist.c
> index 0d878dcd1e4b..449d90cfa151 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4342,12 +4342,13 @@ static int parse_actions(struct
> hist_trigger_data *hist_data)
>  	unsigned int i;
>  	int ret = 0;
>  	char *str;
> +	int len;
>  
>  	for (i = 0; i < hist_data->attrs->n_actions; i++) {
>  		str = hist_data->attrs->action_str[i];
>  
> -		if (str_has_prefix(str, "onmatch(")) {
> -			char *action_str = str + sizeof("onmatch(")
> - 1;
> +		if ((len = str_has_prefix(str, "onmatch("))) {
> +			char *action_str = str + len;
>  
>  			data = onmatch_parse(tr, action_str);
>  			if (IS_ERR(data)) {
> @@ -4355,8 +4356,8 @@ static int parse_actions(struct
> hist_trigger_data *hist_data)
>  				break;
>  			}
>  			data->fn = action_trace;
> -		} else if (str_has_prefix(str, "onmax(")) {
> -			char *action_str = str + sizeof("onmax(") -
> 1;
> +		} else if ((len = str_has_prefix(str, "onmax("))) {
> +			char *action_str = str + len;
>  
>  			data = onmax_parse(action_str);
>  			if (IS_ERR(data)) {

Acked-by: Tom Zanussi <tom.zanussi@linux.intel.com>
