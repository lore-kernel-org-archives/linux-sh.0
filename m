From: Rich Felker <dalias@libc.org>
Date: Sat, 25 Apr 2020 16:22:59 +0000
Subject: Re: [PATCHv3 31/50] sh: Add loglvl to printk_address()
Message-Id: <20200425162259.GK11469@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200418201944.482088-1-dima@arista.com>
 <20200418201944.482088-32-dima@arista.com>
 <20200420155237.1b6532c0d0c6940fccd1b762@linux-foundation.org>
 <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
In-Reply-To: <92cf0382-bdb4-6966-5a77-2ade50fdc451@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, linux-sh@vger.kernel.org

On Sat, Apr 25, 2020 at 11:06:41AM -0500, Rob Landley wrote:
> On 4/20/20 5:52 PM, Andrew Morton wrote:
> > I guess it doesn't matter much, as sh seems to be rather dead.
> 
> The j-core guys are using it.

Yes. There are also Debian/SH folks using classic SH4.

Rich
