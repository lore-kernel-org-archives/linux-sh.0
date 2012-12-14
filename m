From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Dec 2012 03:21:07 +0000
Subject: Re: [PATCH 2/2] ARM: SH-Mobile: sh73a0: Add CPU Hotplug
Message-Id: <CANqRtoQ2OWXsUZU1qMO4iz_BG0oY32b9UYYv+hLSYmzdCEJ24w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1354795719-5578-1-git-send-email-hechtb+renesas@gmail.com>
 <1354795719-5578-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1354795719-5578-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 6, 2012 at 9:08 PM, Bastian Hecht <hechtb@gmail.com> wrote:
> From: Bastian Hecht <hechtb@gmail.com>
>
> Add the capability to add and remove CPUs on the fly.
> The Cortex-A9 offers the possibility to take single cores out of the
> MP Core. We add this capabilty taking care that caches are kept
> coherent. For the actual shutdown via a WFI instruction, a code snippet
> from the omap2 code tree is copied. Thanks for that! For verifying the
> shutdown we rely on the internal SH73A0 Power Status Register
> PSTR.
>
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Acked-by: Magnus Damm <damm@opensource.se>
