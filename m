From: Matt Fleming <mjf@gentoo.org>
Date: Sat, 22 Nov 2008 12:35:35 +0000
Subject: Re: git pull breaks edosk7760 kernel
Message-Id: <20081122123535.GB821@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4927F204.5090805@spesonline.com>
In-Reply-To: <4927F204.5090805@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Nov 22, 2008 at 12:50:28PM +0100, Luca Santini wrote:
> Hi all,
> yesterday i pulled from git and obtained an unbootable kernel.
> My last working pull is dated
>
> commit 882b689432129bfe77530d61f70797147179a742
> Merge: b86c2c0... fb059cd...
> Author: Luca Santini <santox@libero.it>
> Date:   Thu Nov 13 11:31:54 2008 +0100
>
>
> The only thing i was able to do is git reset --hard HEAD^ 
>
> i'm not a god of git... is there a way to "pull step by step" and find the 
> offending patch(es)? --

The usual way to find the commit that introduced a bug is via git-bisect.

Checkout http://www.kernel.org/doc/local/git-quick.html#bisect

