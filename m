From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 29 Aug 2011 07:25:53 +0000
Subject: Re: [PATCH] serial: sh-sci: report CTS as active for get_mctrl
Message-Id: <20110829072553.GF31809@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4E536466.6020604@renesas.com>
In-Reply-To: <4E536466.6020604@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 24, 2011 at 08:04:00PM +0900, takashi.yoshii.zj@renesas.com wrote:
> Hi,
> 
> > This looks reasonable, but what application specifically was hitting
> > this? ...
> 
> Well, it was detected by pure test. So, actually, nobody is in trouble :)
> But I think it occurs on anything that use hardware flow control and write(TX).
> Even shell terminal session does. Try invoke "stty crtscts" on your shell.
> It will freeze your terminal session whatever its flow control setting is.
> Or, do like as followings on ssh session, is safer.
>  $ stty -F /dev/ttySC1 clocal crtscts -echo
>  $ echo x > /dev/ttySC1
> Output 'x' on serial expected, but it stops and no output.
> 
Ok, I've applied it as-is without a stable@ reference, as it's unlikely
to be terribly critical going back. I'll let Greg decided whether to pick
it up for stable or not.
