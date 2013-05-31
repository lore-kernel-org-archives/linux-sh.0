From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 31 May 2013 07:04:02 +0000
Subject: Re: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Message-Id: <CAO3366wx7b3M3VYxxYmW67=rLE2-J=e7yDuEX2VvhYhz4E1uYg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 31, 2013 at 7:48 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, May 29, 2013 at 10:48:56AM +0200, Ulrich Hecht wrote:
>> It is used by the interrupt handler. Fixes crash when booting via kexec
>> on APE6 board.
>
> could you clarify the target of this fix?
> Is it for next and thus v3.11 or is it applicable to v3.10.
> In the case of the latter is it also applicable to earlier
> kernel versions and thus relevant to -stable.

The bug has been introduced by commit e0a5172 (thermal: rcar: add
interrupt support), between v3.8-rc2 and v3.9-rc1.

CU
Uli
