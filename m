From: Anna-Maria Gleixner <anna-maria@linutronix.de>
Date: Tue, 22 Mar 2016 17:20:48 +0000
Subject: FROZEN transition in hotplug notifier
Message-Id: <alpine.DEB.2.11.1603221817270.30089@hypnos>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

the hotplug notifier in arch/sh/kernel/cpu/sh4a/smp-shx3.c doesn't
handle the corresponding FROZEN transitions. Is there a reason for it?

Thanks,
      Anna-Maria
