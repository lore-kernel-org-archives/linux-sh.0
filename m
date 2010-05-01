From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Sat, 01 May 2010 07:01:09 +0000
Subject: Timer handling discussion
Message-Id: <201005010901.09335.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,
I'need to produce a 4KHz square wave to drive a buzzer.I have HZ set to 100; 
so the kernel timer expires each 10ms.
If I use the following scheme:
....
	init_timer(&timer);
	timer.data = (unsigned long) 0;
	timer.function = buzzer_timer;
....

....
	mod_timer(&timer, jiffies);
...
...
static void buzzer_timer(unsigned long handle)
{

//	spin_lock_irq(&lock);

	if (beepEnabled) {
		if (buzzerToggle) {
			ctrl_outw(ctrl_inw(PCDRL) & ~0x0800 ,PCDRL );
			buzzerToggle = 0;
			}
		else  {
			ctrl_outw(ctrl_inw(PCDRL) | 0x0800 ,PCDRL );
			buzzerToggle = 1;
			}
		mod_timer(&timer, jiffies + BUZZER_TIME);
	}
	else {
	}

//	spin_unlock_irq(&lock);
}


I get a 50Hz square wave.

What could be the best way to use the same scheme but with a timer at 5kHz for 
example.

Thanks a lot

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
