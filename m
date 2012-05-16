From: MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
Date: Wed, 16 May 2012 00:51:23 +0000
Subject: ALSA dma_area not utilizing D-cahce
Message-Id: <20120516095123.73abdf103d1ca64996d9c23c@kanno.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi everybody. 
Please advice me to resolve my problem.
1.  My environment
    Hardware	Alpha-project MS104-SH4AG with SH7764
	kernel		sh-linux-2.6.29
2. My problem
	I am ussing a proprietary ALSA driver for SH7764 SSI.
	I have found runtime->dma_area address refers DMA area
	via D-cache.
	So, playback is too late after executing snd_pcm_writei().
	Until D-cache writeback is done, sound data stays in D-cache.
	I want to read and write from/to main memory 
	without D-cache.

3. My idea to solve this problem
	add some codes in xxx_prepare() routine as follows
	
	save_playback_area = runtime->dma_area;
	runtime->dma_area = P2SEGADDR(runtime->dma_area);

Is my idea right?

Best regards.

Masao Takahashi in Japan

---------- 

MASAO TAKAHASHI <masao-takahashi@kanno.co.jp>
KANNO WORKS CO., LTD. JAPAN
TEL 093-436-2330
