From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Mon, 04 Feb 2008 11:37:14 +0000
Subject: Questions regarding mfd drivers
Message-Id: <20080204123714.4be6e10c.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ben@simtech.co.uk, Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, linux-main <linux-kernel@vger.kernel.org>

Greetings,

Trying to wrap my head around sm501. From what I can tell an mfd driver is a "master" driver that takes control of all
memory and io areas. It then hands out areas of those to drivers. Anywhere near correct?

I can see some benefit but still hard for me to motivate. What am I missing? What will the mfd be able to do, that I lack now?

The sm501 driver seems way more advanced than I will need for hd64461/hd64465 anyhow, but still need to understand sm501 completely before
attempting to write one on my own. Anyone know any documentation aside from example drivers?

Best wishes
Kristoffer
