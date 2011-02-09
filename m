From: Kieran Bingham <kieranbingham@gmail.com>
Date: Wed, 09 Feb 2011 15:48:31 +0000
Subject: Re: sh used greatest stack depth: 6628 bytes left
Message-Id: <AANLkTi=kXxqcJX+QABdXi1UBvkAKV4ODiqgDqsY=g6=M@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201102091612.51193.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201102091612.51193.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 9 February 2011 15:12, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
>
> Hi all, what means the subject's message?

CONFIG_DEBUG_STACK_USAGE is enabled,
and /bin/sh has used the largest amount of stack so far.
Which is likely until you run another application.

>
> Is it dangerous?

I don't think its dangerous, its informative!,
and you still have a whopping 6k left of stack.
Don't spend it all at once!

>
> Where could I check it?
>

cd $YOUR_KERNEL
git grep CONFIG_DEBUG_STACK_USAGE

(or google!)

--
Kieran
