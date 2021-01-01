Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C215EC433DB
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 18:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821CA221E9
	for <linux-sh@archiver.kernel.org>; Fri,  1 Jan 2021 18:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbhAASRY (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 1 Jan 2021 13:17:24 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:60965 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbhAASRX (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 1 Jan 2021 13:17:23 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1kvOyf-002bgL-OK; Fri, 01 Jan 2021 19:16:41 +0100
Received: from p5b13a2ad.dip0.t-ipconnect.de ([91.19.162.173] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1kvOyf-003er7-00; Fri, 01 Jan 2021 19:16:41 +0100
Subject: Re: [PATCH] sh: add support for TIF_NOTIFY_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>
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
 <23bf4423-0987-c445-d5cd-1922e1e40820@kernel.dk>
 <f95539e9-506b-c4d9-2861-f288e2d021df@physik.fu-berlin.de>
 <10752e73-ca2a-9ea7-4aa6-35e366e36fb0@kernel.dk>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <b16ed393-e2bf-deca-d0d9-614d24ee6406@physik.fu-berlin.de>
Date:   Fri, 1 Jan 2021 19:16:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <10752e73-ca2a-9ea7-4aa6-35e366e36fb0@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.162.173
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On 1/1/21 4:35 PM, Jens Axboe wrote:> It's supposed to finish very quickly:
> 
> axboe@p1 ~> time ./socket-rw                                                             0.000s
> 
> ________________________________________________________
> Executed in    1.10 millis    fish           external 
>    usr time  888.00 micros  278.00 micros  610.00 micros 
>    sys time   35.00 micros   35.00 micros    0.00 micros 
> 
> If it doesn't, can you try:
> 
> # echo 1 > /sys/kernel/debug/tracing/events/io_uring/enable
> 
> Then run the socket-rw app, and then do:
> 
> # cat /sys/kernel/debug/tracing/trace
> 
> and send that output? Might also be useful to include the strace
> of the socket-rw just in case, so maybe run it ala
> 
> strace -o foo ./socket-rw
> 
> and include foo in the reply as well.

Odd, I just ran it through strace and it exited immediately:

root@tirpitz:~> strace ./socket-rw 
execve("./socket-rw", ["./socket-rw"], 0x7bb26670 /* 25 vars */) = 0
brk(NULL)                               = 0x412000
uname({sysname="Linux", nodename="tirpitz", ...}) = 0
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=64232, ...}) = 0
mmap2(NULL, 64232, PROT_READ, MAP_PRIVATE, 3, 0) = 0x29584000
close(3)                                = 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x29574000
openat(AT_FDCWD, "/usr/lib/sh4-linux-gnu/liburing.so.1", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0*\0\1\0\0\0\324\17\0\0004\0\0\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=9536, ...}) = 0
mmap2(NULL, 73852, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x29594000
mprotect(0x29596000, 61440, PROT_NONE)  = 0
mmap2(0x295a5000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x295a5000
close(3)                                = 0
openat(AT_FDCWD, "/lib/sh4-linux-gnu/libc.so.6", O_RDONLY|O_LARGEFILE|O_CLOEXEC) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0*\0\1\0\0\0\224\306\1\0004\0\0\0"..., 512) = 512
pread64(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\3\0\0\0\2\0\0\0\0\0\0\0", 32, 1290836) = 32
fstat64(3, {st_mode=S_IFREG|0755, st_size=1297036, ...}) = 0
mmap2(NULL, 1366256, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x295a8000
mprotect(0x296e1000, 61440, PROT_NONE)  = 0
mmap2(0x296f0000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x138000) = 0x296f0000
mmap2(0x296f4000, 6384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x296f4000
close(3)                                = 0
mprotect(0x296f0000, 8192, PROT_READ)   = 0
mprotect(0x295a5000, 4096, PROT_READ)   = 0
mprotect(0x410000, 4096, PROT_READ)     = 0
mprotect(0x29582000, 4096, PROT_READ)   = 0
munmap(0x29584000, 64232)               = 0
socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_TCP) = 3
setsockopt(3, SOL_SOCKET, SO_REUSEPORT, [1], 4) = 0
setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
bind(3, {sa_family=AF_INET, sin_port=htons(13586), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
listen(3, 128)                          = 0
socket(AF_INET, SOCK_STREAM|SOCK_CLOEXEC, IPPROTO_TCP) = 4
setsockopt(4, SOL_TCP, TCP_NODELAY, [1], 4) = 0
fcntl64(4, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(4, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
connect(4, {sa_family=AF_INET, sin_port=htons(13586), sin_addr=inet_addr("127.0.0.1")}, 16) = -1 EINPROGRESS (Operation now in progress)
fcntl64(4, F_GETFL)                     = 0x802 (flags O_RDWR|O_NONBLOCK)
fcntl64(4, F_SETFL, O_RDWR)             = 0
accept(3, NULL, NULL)                   = 5
getsockopt(4, SOL_SOCKET, SO_ERROR, [0], [4]) = 0
io_uring_setup(32, {flags=0, sq_thread_cpu=0, sq_thread_idle=0, sq_entries=32, cq_entries=64, features=IORING_FEAT_SINGLE_MMAP|IORING_FEAT_NODROP|IORING_FEAT_SUBMIT_STABLE|IORING_FEAT_RW_CUR_POS|IORING_FEAT_CUR_PERSONALITY|0x1e0, sq_off={head=0, tail=4, ring_mask=16, ring_entries=24, flags=36, dropped=32, array=1072}, cq_off={head=8, tail=12, ring_mask=20, ring_entries=28, overflow=44, cqes=48, resv=[0x28, 0]}}) = 6
mmap2(NULL, 1200, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_POPULATE, 6, 0) = 0x29576000
mmap2(NULL, 2048, PROT_READ|PROT_WRITE, MAP_SHARED|MAP_POPULATE, 6, 0x10000000) = 0x29578000
io_uring_enter(6, 2, 2, IORING_ENTER_GETEVENTS, NULL, 8) = 2
munmap(0x29578000, 2048)                = 0
munmap(0x29576000, 1200)                = 0
close(6)                                = 0
exit_group(0)                           = ?
+++ exited with 0 +++
root@tirpitz:~>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

