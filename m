From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 13 Jan 2014 13:46:31 +0000
Subject: Re: [PATCH v5] can: add Renesas R-Car CAN driver
Message-Id: <52D3EE37.9070403@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201312270037.15822.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312270037.15822.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, linux-can@vger.kernel.org
Cc: linux-sh@vger.kernel.org, vksavl@gmail.com

Hello.

On 27-12-2013 1:37, Sergei Shtylyov wrote:

> Add support for the CAN controller found in Renesas R-Car SoCs.

> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> ---
> The patch is against the 'linux-can-next.git' repo.

> Changes in version 5:
> - removed the code specific to the mailbox mode handling and added the code
>    for the FIFO mode, dropping support for CAN_CTRLMODE_ONE_SHOT;
> - stop accumulating errors in the byte 1 of an error frame;
> - added #define RCAR_CAN_CTLR_CANM for CTLR.CANM field, added 'CANM_' infix to
>    all its values;
> - replaced ~RCAR_CAN_CTLR_CANM_FORCE_RESET with ~RCAR_CAN_CTLR_CANM;
> - added polling for the CAN reset status bit when going from/to CAN reset.

    Wolfgang, Marc, there has been no feedback from you on the last version, 
working in FIFO mode. Ping!

WBR, Sergei

