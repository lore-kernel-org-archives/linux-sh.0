From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 06 Feb 2008 23:28:25 +0000
Subject: HP6xx : weird hwclock behavior, bug?
Message-Id: <20080207002825.96bfbf6b.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

Is this a bug, or am I just confusing stuff?

hwclock --show = works
hwclock --systohc = freezes system

Its hard to say wether it ever worked since we haven't used the rtc much.

