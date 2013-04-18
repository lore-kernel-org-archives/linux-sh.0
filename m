From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 18 Apr 2013 05:23:57 +0000
Subject: Re: r8a7779_init_irq_extpin
Message-Id: <CANqRtoRS+saydji8mT2_25GY-kO+1Kmm93D38LSZJQYOFSJakw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130417063526.GA21490@verge.net.au>
In-Reply-To: <20130417063526.GA21490@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Apr 17, 2013 at 3:35 PM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> r8a7779_init_irq_extpin() and related code was added in your
> patch "ARM: shmobile: Use Renesas INTC External IRQ pin driver"
> but appears to be unused.
>
> Are you still planning to use it?

Perhaps I'm misunderstanding, but isn't it used by the Marzen board code in:
[PATCH 03/03] ARM: shmobile: INTC External IRQ pin driver on r8a7779

Thanks,

/ magnus
