From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 23 Jul 2020 13:14:03 +0000
Subject: Re: [PATCH] sh: clk: Fix assignment from incompatible pointer type for ioreadX()
Message-Id: <ca946348-f878-46c5-cf69-1c160eb12b88@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200723082017.24053-1-krzk@kernel.org>
 <c77eb720-1ded-f9d4-fbe4-92429e81857f@physik.fu-berlin.de>
 <20200723125732.GA9795@kozik-lap>
In-Reply-To: <20200723125732.GA9795@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Hi!

On 7/23/20 2:57 PM, Krzysztof Kozlowski wrote:
> The patch is for Andrew Morton's tree which contain two commits:
> 1. sh: clkfwk: remove r8/r16/r32
> 2. iomap: constify ioreadX() iomem argument (as in generic implementation)
> 
> This patch here was actually part of #2 because of being based on
> linux-next. However it disappeared when applying to Andrew's tree
> because patch #1 came later.

Okay. I'll try to look at the other two patches later.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
