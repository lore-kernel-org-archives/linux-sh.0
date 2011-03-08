From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Mar 2011 03:35:19 +0000
Subject: Re: [PATCH 2/5] mmc: tmio: add a flag to prohibit access to registers
Message-Id: <AANLkTi=ecc4_82vt1fkN6Bx2r0k6Vpb7PrvG7S=smbQp@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1103071937010.29543@axis700.grange>
	<Pine.LNX.4.64.1103071944200.29543@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1103071944200.29543@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

On Tue, Mar 8, 2011 at 3:47 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On some implementations there are no registers above 0xff and any
> access to them mirrors to registers at addresses with bit 8 masked
> out, which leads to malfunction. Add a flag to prevent such accesses.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Yes, this is correct for SDHI. Thanks for your help!

Acked-by: Magnus Damm <damm@opensource.se>
