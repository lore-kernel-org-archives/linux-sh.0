From: "Kieran Bingham" <kieranbingham@gmail.com>
Date: Fri, 08 Feb 2008 00:44:23 +0000
Subject: Re: Sorry but I do not understand.
Message-Id: <82bcfa4d0802071644y1b1c9d11v7f9e2d9a04902157@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200802072128.34795.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200802072128.34795.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Normal: 7*4kB 6*8kB 3*16kB 3*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB
0*2048kB ___2*4096kB___ = 9244kB

If those are the free pages ... Doesn't 1072838 bytes fit inside one
of the 4096000 pages? or was it denied this page because of the huge
amount it would waste ?
-- 
KB

On 08/02/2008, Mike Frysinger <vapier@gentoo.org> wrote:
> On Thursday 07 February 2008, Fabio Giovagnini wrote:
> > What exaclty means this following:
> > root:/home> cp nfs/sdl5thApp .
> > root:/home> ./sdl5thApp
> > Allocation of length 1072838 from process 48 failed
>
> your memory is full and/or fragmented and cannot satisfy the request for
> 1072838 bytes.  the rest of the message just describes the exact memory state
> in the system at the time of failure.
> -mike
>
>
