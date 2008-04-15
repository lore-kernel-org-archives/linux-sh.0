From: Junio C Hamano <gitster@pobox.com>
Date: Tue, 15 Apr 2008 18:41:52 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.25
Message-Id: <7vr6d7x8nj.fsf@gitster.siamese.dyndns.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080415172333.GA29489@linux-sh.org>
 <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.1.00.0804151048060.2879@woody.linux-foundation.org>
 (Linus Torvalds's message of "Tue, 15 Apr 2008 11:01:36 -0700 (PDT)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Git Mailing List <git@vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Junio? Something like this for the merge summary code? (It also turns an 
> empty commit message with just whitespace in the commit message into the 
> SHA1 hex string)

Yeah, your patch makes sense, but it also makes me wonder if we should fix
the code in pretty.c::parse_commit_header() that grabs the "subject" line,
and use format_commit_message() with "%s" format here.  Interested people
then can enhance it to take custom format string.

> 		Linus
>
> ----
>  builtin-fmt-merge-msg.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
>
> diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
> index ebb3f37..7077d52 100644
> --- a/builtin-fmt-merge-msg.c
> +++ b/builtin-fmt-merge-msg.c
> @@ -201,6 +201,15 @@ static void shortlog(const char *name, unsigned char *sha1,
>  			continue;
>  
>  		bol = strstr(commit->buffer, "\n\n");
> +		if (bol) {
> +			unsigned char c;
> +			do {
> +				c = *++bol;
> +			} while (isspace(c));
> +			if (!c)
> +				bol = NULL;
> +		}
> +
>  		if (!bol) {
>  			append_to_list(&subjects, xstrdup(sha1_to_hex(
>  							commit->object.sha1)),
> @@ -208,7 +217,6 @@ static void shortlog(const char *name, unsigned char *sha1,
>  			continue;
>  		}
>  
> -		bol += 2;
>  		eol = strchr(bol, '\n');
>  		if (eol) {
>  			oneline = xmemdupz(bol, eol - bol);
