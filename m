From: Jiri Pirko <jiri@resnulli.us>
Date: Sat, 25 Jul 2015 20:40:37 +0000
Subject: Re: [PATCH] ravb: minimize TX data copying
Message-Id: <20150725204037.GA2172@nanopsycho.fritz.box>
List-Id: <linux-sh.vger.kernel.org>
References: <7692456.7SI5hJLWyQ@wasted.cogentembedded.com>
In-Reply-To: <7692456.7SI5hJLWyQ@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org

Sat, Jul 25, 2015 at 09:20:30PM CEST, sergei.shtylyov@cogentembedded.com wrote:

<snip>

>The patch is against Dave Miller's 'net-next.git' repo.

You can just put "net-next" into patch brackets like:
[patch net-next] whatever
That would do the trick :)
