From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 23 May 2014 08:52:06 +0000
Subject: Re: R-CAR's arch
Message-Id: <1400835126.4451.18.camel@chaos.site>
List-Id: <linux-sh.vger.kernel.org>
References: <20140522101938.51fec16f@endymion.delvare>
In-Reply-To: <20140522101938.51fec16f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

Le Friday 23 May 2014 à 10:39 +0200, Geert Uytterhoeven a écrit :
> Hi Jean,
> 
> On Fri, May 23, 2014 at 10:23 AM, Jean Delvare <jdelvare@suse.de> wrote:
> > For USB PHY the dependencies are clear. For VIN I'm not so sure, does
> > anybody know? I'd got for ARCH_SHMOBILE || COMPILE_TEST but I don't know
> > if SUPERH should be listed too.
> 
> R-Car falls under shmobile (which also covers Emma Mobile and R-Mobile).
> I.e. no SUPERH.

OK. Patch written and sent, thanks!

-- 
Jean Delvare
SUSE L3 Support

