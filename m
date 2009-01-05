From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Jan 2009 22:15:54 +0000
Subject: Re: Fw: SH7709 BUG on boot (partially bisected)
Message-Id: <20090105221554.GA28785@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
In-Reply-To: <OF2E8062F8.007117EA-ON80257530.004D178D-80257530.004E3CFB@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 05, 2009 at 12:48:26PM +0000, Steve.Glendinning@smsc.com wrote:
> Thanks Paul,
> 
> With your gcc 4.2.1 toolchain and today's linus git tree my platform's 
> physmap flash works again.  I also tested the "bad" revision from my 
> bisection and this also works fine with gcc 4.2.1.
> 
Good to hear!

> I'll use 4.2.1 from now onwards, so I'm happy, but if this is still 
> something you still want to fix I'm happy to test patches with 3.4.4.
> 
I did test these patches with a gcc 3.4.5 version that was fairly close
to standard, so I expect that the version of 3.4.4 you are using has
quite a few patches. In any event, gcc 3.x is old enough now that there
are not many people still building on it, so I wouldn't worry about it.
