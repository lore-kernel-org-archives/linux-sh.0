From: morimoto.kuninori@renesas.com
Date: Wed, 15 Apr 2009 02:40:19 +0000
Subject: [PATCH 0/6] Add support SH7724 CPU series
Message-Id: <uhc0q3ai4.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


SH7724 CPU support patch series

[PATCH 1/6] Add support for SH7724 CPU subtype
[PATCH 2/6] sh-sci: Add support SH7724 support
[PATCH 3/6] Add USB support for SH7724
[PATCH 4/6] Add I2C support for SH7724
[PATCH 5/6] Add VPU support for SH7724
[PATCH 6/6] Add VEU support for SH7724

1st patch change clock-sh7722.c with some #ifdef and macro.
So, please check it carefully.

These patches are based on Rev 0.11 manual.

These patch series are tested by ms7724se board.
But I can not send this board support patch.
Because this is not W/W reference board.

# I'm sorry about timestamps problem.
# May be this time OK...
