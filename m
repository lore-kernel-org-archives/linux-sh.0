From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Mon, 14 Jul 2014 09:55:09 +0000
Subject: A question about L2$ initialization for Lager/Koelsch board
Message-Id: <53C3A8FD.1010801@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san, 
cc Simon-san,

I have a question about L2$ initialization for Lager/Koelsch board.

In my understanding, there are 2 methods to initialize L2$:
1. Call l2x0_init() explicitly during platform setup.
   Like H1/Armadillo800eva or RZ/kzm9g
2. Declare in DTSI file and l2x0_of_init() will be called.
   Like some other platforms, e.g omap4, tegra20

I'm checking L2$ initialization for Lager/Koelsch, 
but I still cannot find the code.

Could you tell me current method to initialize L2$ ?
(or we rely on L2$ initialization of bootloader)

Thanks.
-- 
Best regards,
KHIEM Nguyen
