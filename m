From: "Yann E. MORIN" <yann.morin.1998@free.fr>
Date: Sat, 27 Jul 2013 13:29:15 +0000
Subject: Re: Build regressions/improvements in v3.11-rc2
Message-Id: <20130727132915.GA3655@free.fr>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.02.1307232209510.32497@ayla.of.borg>
 <alpine.DEB.2.02.1307232210440.32577@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.02.1307232210440.32577@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, Andrew Veliath <andrewtv@usa.net>, linux-kbuild@vger.kernel.org, linux-sh@vger.kernel.org

Geert, All,

Sorry to chime in a bit late...

On 2013-07-23 22:20 +0200, Geert Uytterhoeven spake thusly:
> On Tue, 23 Jul 2013, Geert Uytterhoeven wrote:
> > JFYI, when comparing v3.11-rc2 to v3.11-rc1[3], the summaries are:
> >   - build errors: +9/-23
[--SNIP--]
> powerpc-randconfig, due to a kconfig issue:
> 
> Expose SCOM controllers via debugfs (SCOM_DEBUGFS) [N/y] (NEW) aborted!
> Console input/output is redirected. Run 'make oldconfig' to update configuration
> .
> make[3]: *** [silentoldconfig] Error 1

Can you give me instructions on how to reproduce this error?

randconfig now should print the RNF seed, so that's d be nice to have to
reproduce the error. Also, having the problematic changeset would be
nice.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 223 225 172 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
