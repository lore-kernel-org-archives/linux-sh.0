From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 20 Jan 2011 06:26:51 +0000
Subject: Re: linux 2.6.37+ seems to go to sleep
Message-Id: <201101200726.51944.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201101191719.05926.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,
could you write to me please the exact cmdline to put in boot option and / or 
bootargs env variable of u-boot?

Thanks


On Thursday 20 January 2011 02:00:22 Magnus Damm wrote:
> Hi Fabio,
> 
> On Thu, Jan 20, 2011 at 1:19 AM, Fabio Giovagnini
> 
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi All,
> > using the emulator and u-boot  together, I have seen that my kernel stops
> > into sleep instruction.
> 
> Sounds like a fully working system to me - the sleep instruction is
> normally used by the idle loop for power management purpose.
> 
> > How could I avoid this?
> 
> Not sure why you would like to do so, but the kernel command line
> option "nohlt" may help if you wish to disable CPU core power
> managment.
> 
> > Is it possible I cannot see anything on the serial terminal because of
> > this sleep instruction?
> 
> I don't think so. You most likely don't see anything because you have
> problems with your serial console.
> 
> Why don't you try using "earlyprintk" to get early console printouts
> from your SCIF port?
> 
> Cheers,
> 
> / magnus

-- 
Ing. Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
skype: aurion.giovagnini
Tel. +39.051.594.78.24
Fax. +39.051.082.14.49
Cell. +39.335.83.50.919
www.aurion-tech.com
