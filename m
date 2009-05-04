From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 04 May 2009 14:14:46 +0000
Subject: Re: 2.6.30-rc4-git: timer-related oops
Message-Id: <20090504141446.GC27580@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20090504091430.GA30660@linux-sh.org>
In-Reply-To: <20090504091430.GA30660@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 04, 2009 at 11:15:23AM +0200, Manuel Lauss wrote:
> Hello!
> 
> Current -git (and a few revisions before that) oops when kernel tries to
> mount nfsroot.  Anyone else seeing this?  (system is SH7760; I disabled
> almost all of my platform code to rule out a screwup on my part. The code
> works on 2.6.29).

Gaah, found it:  CONFIG_4KSTACKS=y is the culprit.  Removing it gives me a
nicely working system again.

Sorry for the noise!

	Manuel Lauss

