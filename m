From: Ian Molton <ian.molton@codethink.co.uk>
Date: Tue, 03 Sep 2013 16:55:02 +0000
Subject: [PATCH v1] EMMA SPI driver
Message-Id: <1378227303-18795-1-git-send-email-ian.molton@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi folks, This is a first cut at SPI for the EMEV2 (1?) platform.

The driver works on our hardware, however we have an unusual chipselect mux.

I've replaced that with a pure GPIO based chipselect option in the driver,
which would allow us to model the MUX as a gpiochip on our board. Sadly, I
do not have the time to work further on this, so this part is merely compile
tested.

I've had no problems running 4 slaves on GPIO chipselects (via the mux) at
1.5MHz

-Ian

