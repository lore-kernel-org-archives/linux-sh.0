From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Nov 2013 23:24:11 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: kzm9g: add zboot support
Message-Id: <CANqRtoR-vUpv6N2u5rzAqJECJAbuq5_kurxOFcX3pxUerpdfVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385499200-27772-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1385499200-27772-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 27, 2013 at 5:53 AM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> Adds support to run the kernel on the uninitialized KZM9G board, using for
> instance the mask ROM boot loader or JTAG. This patch tries to emulate the
> style of the corresponding "mackerel" implementation. The DRAM controller
> setup code has been adapted from u-boot.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>

Hey Ulrich,

Thanks for your continued efforts on this! =)

If I want to test this on my own KZM9G board, perhaps you can tell me
quickly if I can use USB gadget Mask ROM boot mode somehow? I'd like
to use the "r_usb_boot" tool but I wonder if it needed any
modifications to work with sh73a0?

Cheers,

/ magnus
