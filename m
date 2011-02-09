From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 09 Feb 2011 16:15:12 +0000
Subject: Re: sh used greatest stack depth: 6628 bytes left
Message-Id: <201102091715.12835.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102091612.51193.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201102091612.51193.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Kieram
Is it possible to avoid this stack overflow or the kernel automatically adjust 
then stack size if an application overflow it?

Thanks a lot


On Wednesday 09 February 2011 16:44:24 Kieran Bingham wrote:
> On 9 February 2011 15:12, Fabio Giovagnini
> <fabio.giovagnini@aurion-tech.com
> 
> > wrote:
> > 
> > Hi all, what means the subject's message?
> 
> CONFIG_DEBUG_STACK_USAGE is enabled,
> and /bin/sh has used the largest amount of stack so far.
> Which is likely until you run another application.
> 
> > Is it dangerous?
> 
> I don't think its dangerous, its informative!,
> and you still have a whopping 6k left of stack.
> Don't spend it all at once!
> 
> > Where could I check it?
> 
> cd $YOUR_KERNEL
> git grep CONFIG_DEBUG_STACK_USAGE
> 
> (or google!)
> 
> --
> Kieran
> 
> 
> 
> 
> 
> Thanks
> 
> > --
> > Ing. Fabio Giovagnini
> > 
> > Aurion s.r.l.
> > P.I e C.F.
> > 00885711200
> > skype: aurion.giovagnini
> > Tel. +39.051.594.78.24
> > Fax. +39.051.082.14.49
> > Cell. +39.335.83.50.919
> > www.aurion-tech.com
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
