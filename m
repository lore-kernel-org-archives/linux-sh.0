From: morimoto.kuninori@renesas.com
Date: Wed, 28 Jan 2009 01:25:05 +0000
Subject: Re: [bug report] dead lock (?) occur on ap325 board
Message-Id: <uocxsz0ge.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uprie4cmj.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> Hmm, the !__ex_flag should have handled that case properly, but I wonder
> if it is negated in the unlock case. Does switching to __res |= __ex_flag
> and leaving the existing test as-is fix it?

On my stupid opinion, dead lock will occur 

    if ( __res = 1 &&
         __ex_flag = 0) {

         /* this case, dead lock will occur
          *
          * it mean interrupt occur
          */
    }

      /*
       * __res will be 1 even if __ex_flag = 0
       *
       * __res = 1
       * __ex_flag = 0
       * count->counter = 0  <= not changed
       *
       */
	__res |= !__ex_flag;
 	if (unlikely(__res <= 0))
                 fail_fn(count)    <= this function should be
                                      called if __ex_flag = 0
                                      or __res != count->counter

how about this ?
--------------------------------------------------
-	__res |= !__ex_flag;
-	if (unlikely(__res <= 0))
+	if (unlikely(__res <= 0 || !__ex_flag))
 		fail_fn(count);
--------------------------------------------------

Best regards
--
Kuninori Morimoto
 
