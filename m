From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Sat, 29 Dec 2007 22:14:56 +0000
Subject: Re: NFS root failing
Message-Id: <4776C6E0.8030305@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1198940473.6278.20.camel@localhost.localdomain>
In-Reply-To: <1198940473.6278.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adrian McMenamin schrieb:
> I've been getting nowhere with it for a few days now: I had this (NFS
> root) working very well until earlier this week when I upgraded the
> Busybox config on target system. Now it fails - any experts able to
> help?

Maybe the patch in here will help:
http://lkml.org/lkml/2007/12/29/80

-- 
  ml.
