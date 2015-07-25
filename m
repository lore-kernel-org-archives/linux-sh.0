From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 25 Jul 2015 20:49:27 +0000
Subject: Re: [PATCH] ravb: minimize TX data copying
Message-Id: <55B3F657.8090606@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <7692456.7SI5hJLWyQ@wasted.cogentembedded.com>
 <20150725204037.GA2172@nanopsycho.fritz.box>
In-Reply-To: <20150725204037.GA2172@nanopsycho.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-sh@vger.kernel.org, David Miller <davem@davemloft.net>

Hello.

On 07/25/2015 11:40 PM, Jiri Pirko wrote:

> <snip>

>> The patch is against Dave Miller's 'net-next.git' repo.

    Dave, don't apply this yet, I'll post v2 with couple of comments fixed up.

> You can just put "net-next" into patch brackets like:
> [patch net-next] whatever
> That would do the trick :)

    Oh, I know. :-)
    I just prefer to do this kind of thing uniformly regardless of the target 
repo.

MBR, Sergei

