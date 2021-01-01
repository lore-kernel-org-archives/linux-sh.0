Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2010C433E0
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 15:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA2A216FD
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 15:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbhAAPIx (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 10:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbhAAPIx (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 10:08:53 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD390C061573
        for <linux-sh@vger.kernel.org>; Fri,  1 Jan 2021 07:08:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 4so11178501plk.5
        for <linux-sh@vger.kernel.org>; Fri, 01 Jan 2021 07:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=jpse/NW7Fi81gf2EgpperrGALE0yWxOZPeeoc6T3Jmc=;
        b=I/8YkIS03HITVTB714ajEkQpDZU27HxB78rKrLMzRDq+VLkoFOHhluULWzu0vHiOF8
         tnoiCOj2NhxO/YyWI2q6XsTUCN/u92mn4GqCLtu4wjraA2ZN2XTYcn9AtCCt3f+ODAqS
         jMFHQhiCMmIORS2B0p4mDldCX2tOllZQG1ZW2p4OQqlr8M1JMW/6t8kq/Og4PW4EN6Cw
         Tb0qChx5OAu3kyMJGVlA2bV3wRAyyXobqw2meXKhqYZRtevYEzBh6W3gWpmLEI/gHHvd
         fb+9EWo1gDnu12rZWMn09NT/PIUQvVjCnXBDArNyPNiKvhjuSNSDm4Wqc5EJNsydl4kP
         9b9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=jpse/NW7Fi81gf2EgpperrGALE0yWxOZPeeoc6T3Jmc=;
        b=ljtadfc7XbsvAm5RlS9z60be7qn5hYI5mYnnRczr5Sj+jZYRB4g4HAoV6G3Zfv+Lcl
         PVSEjMQpsJwc2mx1/6zYgEdO8I4z3vKi+9wTn1INxra26t6fNESp6evXHzh4DKRDjx1d
         xvG7kNgDVrAXdXyfpfBcmJeNj9Jloh2LpobRSM/y215a6OJqG3+DkXGi1H9xcS00j9kd
         KNBpztLxbObe2yYRSDHHfnbolG7QXEtGp1TBcow9J233oEJmMCajpSrsgEEo4AlCtRTy
         mnlgQb7IHKvp8bfJelYYOZyRtEkykT9S876she+JNvh/1nHgGFm4+1p7aHTQ7dsCP1QP
         WrKw==
X-Gm-Message-State: AOAM53307R5DGqcQ3AelDb6ULfLUZKr1/pOQTj9LGYB/hnOW16KUvPlO
        8ywMCXUv9d735VKJcZKx8Qx5Kw==
X-Google-Smtp-Source: ABdhPJy6O4j8nPXX5x5pIvFEPCiYQ2poD5N2mwqEgu9ojd1RZwgifek1NU2WYDKe3vWhxDtSrpuQ6Q==
X-Received: by 2002:a17:90b:f89:: with SMTP id ft9mr17734479pjb.219.1609513691185;
        Fri, 01 Jan 2021 07:08:11 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:7a2f:4758:8d40:5fe5? (2603-8001-2900-d1ce-7a2f-4758-8d40-5fe5.res6.spectrum.com. [2603:8001:2900:d1ce:7a2f:4758:8d40:5fe5])
        by smtp.gmail.com with ESMTPSA id a11sm50023232pfr.198.2021.01.01.07.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jan 2021 07:08:10 -0800 (PST)
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>
References: <5fcc82b4-89ae-3bca-10ab-6ad933565cee@kernel.dk>
 <ae29ab73-ee7a-2bb7-3fd8-3037f40c1cbd@kernel.dk>
 <5611bde9-67e7-6ff6-defc-9b02ea830fac@physik.fu-berlin.de>
 <9ea14eb3-d698-5499-ba4c-c6a3c35cd8d4@kernel.dk>
 <47f79645-53b7-b11c-167a-f5721b53df02@physik.fu-berlin.de>
 <9d9acec6-1e8c-2d68-5dfa-d58c11cf5cc4@kernel.dk>
 <070780c4-445e-6373-c8f4-1c72d0f3b4e0@physik.fu-berlin.de>
 <1047f3e5-4599-c34f-3176-9f41d2e1246b@kernel.dk>
 <31b34cfc-8d6e-d3b4-e29f-1ec485f5b368@physik.fu-berlin.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23bf4423-0987-c445-d5cd-1922e1e40820@kernel.dk>
Date:   Fri, 1 Jan 2021 08:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <31b34cfc-8d6e-d3b4-e29f-1ec485f5b368@physik.fu-berlin.de>
Content-Type: multipart/mixed;
 boundary="------------9291C5EC8B81DEC53F64DD54"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------9291C5EC8B81DEC53F64DD54
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 1/1/21 7:06 AM, John Paul Adrian Glaubitz wrote:
> Hi Jens!
> 
> On 11/17/20 4:06 PM, Jens Axboe wrote:
>> On 11/16/20 10:26 PM, John Paul Adrian Glaubitz wrote:
>>> Hi Jens!
>>>
>>> On 11/9/20 3:14 PM, Jens Axboe wrote:
>>>>> Sorry for the delay. I'm busy at the moment and my SH board is currently
>>>>> building the Perl 5.32 package for Debian. Will try to test your patches
>>>>> by tomorrow, also ia64.
>>>>
>>>> Thanks, both would be appreciated! Just CC'ed you on the updated patch
>>>> for sh.
>>>
>>> Is this still relevant for testing? I'm ready to test now, much later than
>>> I thought, sorry.
>>>
>>> I'm going to build Linus' latest kernel for my SH and IA64 machines now
>>> and then I can test additional patches on top of it.
>>
>> Thanks, would definitely still appreciate testing. You can just run
>> linux-next if you want, it's got everything in there. Or apply the
>> separate patches to -git, either approach is fine.
> 
> Apologies for the late reply.
> 
> I just pulled Linus' latest tree today with your patch for SH included and
> I'm not seeing any regressions.
> 
> Is there away to test the change itself?

The only user of TWA_SIGNAL, which uses TIF_NOTIFY_SIGNAL, so far is io_uring.
You need something that triggers deferred task_work processing, which is
basically anything that ends up being poll driven for data/space readiness.
Here's a small test app from the liburing test suite, that'll trigger it.

If you install liburing, compile with:

gcc -Wall -O2 -o socket-rw socket-rw.c -luring

and run it without any arguments.

-- 
Jens Axboe


--------------9291C5EC8B81DEC53F64DD54
Content-Type: text/x-csrc; charset=UTF-8;
 name="socket-rw.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="socket-rw.c"

/* SPDX-License-Identifier: MIT */
/*
 * Check that a readv on a socket queued before a writev doesn't hang
 * the processing.
 *
 * From Hrvoje Zeba <zeba.hrvoje@gmail.com>
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <assert.h>

#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/tcp.h>
#include <netinet/in.h>

#include <liburing.h>

int main(int argc, char *argv[])
{
	int p_fd[2], ret;
	int32_t recv_s0;
	int32_t val = 1;
	struct sockaddr_in addr;

	if (argc > 1)
		return 0;

	recv_s0 = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);

	ret = setsockopt(recv_s0, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val));
	assert(ret != -1);
	ret = setsockopt(recv_s0, SOL_SOCKET, SO_REUSEADDR, &val, sizeof(val));
	assert(ret != -1);

	addr.sin_family = AF_INET;
	addr.sin_port = 0x1235;
	addr.sin_addr.s_addr = 0x0100007fU;

	ret = bind(recv_s0, (struct sockaddr*)&addr, sizeof(addr));
	assert(ret != -1);
	ret = listen(recv_s0, 128);
	assert(ret != -1);


	p_fd[1] = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);

	val = 1;
	ret = setsockopt(p_fd[1], IPPROTO_TCP, TCP_NODELAY, &val, sizeof(val));
	assert(ret != -1);

	int32_t flags = fcntl(p_fd[1], F_GETFL, 0);
	assert(flags != -1);

	flags |= O_NONBLOCK;
	ret = fcntl(p_fd[1], F_SETFL, flags);
	assert(ret != -1);

	ret = connect(p_fd[1], (struct sockaddr*)&addr, sizeof(addr));
	assert(ret == -1);

	flags = fcntl(p_fd[1], F_GETFL, 0);
	assert(flags != -1);

	flags &= ~O_NONBLOCK;
	ret = fcntl(p_fd[1], F_SETFL, flags);
	assert(ret != -1);

	p_fd[0] = accept(recv_s0, NULL, NULL);
	assert(p_fd[0] != -1);

	while (1) {
		int32_t code;
		socklen_t code_len = sizeof(code);

		ret = getsockopt(p_fd[1], SOL_SOCKET, SO_ERROR, &code, &code_len);
		assert(ret != -1);

		if (!code)
			break;
	}

	struct io_uring m_io_uring;

	ret = io_uring_queue_init(32, &m_io_uring, 0);
	assert(ret >= 0);

	char recv_buff[128];
	char send_buff[128];

	{
		struct iovec iov[1];

		iov[0].iov_base = recv_buff;
		iov[0].iov_len = sizeof(recv_buff);

		struct io_uring_sqe* sqe = io_uring_get_sqe(&m_io_uring);
		assert(sqe != NULL);

		io_uring_prep_readv(sqe, p_fd[0], iov, 1, 0);
	}

	{
		struct iovec iov[1];

		iov[0].iov_base = send_buff;
		iov[0].iov_len = sizeof(send_buff);

		struct io_uring_sqe* sqe = io_uring_get_sqe(&m_io_uring);
		assert(sqe != NULL);

		io_uring_prep_writev(sqe, p_fd[1], iov, 1, 0);
	}

	ret = io_uring_submit_and_wait(&m_io_uring, 2);
	assert(ret != -1);

	struct io_uring_cqe* cqe;
	uint32_t head;
	uint32_t count = 0;

	while (count != 2) {
		io_uring_for_each_cqe(&m_io_uring, head, cqe) {
			assert(cqe->res == 128);
			count++;
		}

		assert(count <= 2);
		io_uring_cq_advance(&m_io_uring, count);
	}

	io_uring_queue_exit(&m_io_uring);
	return 0;
}

--------------9291C5EC8B81DEC53F64DD54--
